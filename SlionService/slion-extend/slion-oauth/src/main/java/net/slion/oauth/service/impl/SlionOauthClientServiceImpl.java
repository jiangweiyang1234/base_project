package net.slion.oauth.service.impl;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import net.slion.common.core.exception.ServiceException;
import net.slion.common.core.utils.MapstructUtils;
import net.slion.common.core.utils.StringUtils;
import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import net.slion.oauth.domain.SlionOauthClient;
import net.slion.oauth.domain.bo.SlionOauthClientBo;
import net.slion.oauth.domain.vo.SlionOauthClientVo;
import net.slion.oauth.mapper.SlionOauthClientMapper;
import net.slion.oauth.service.ISlionOauthClientService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Objects;

/**
 * OAuth2 开放应用 Service 实现
 */
@RequiredArgsConstructor
@Service
public class SlionOauthClientServiceImpl implements ISlionOauthClientService {

    private static final String DEFAULT_GRANT = "client_credentials";
    private static final String DEFAULT_SCOPE = "open.api";
    private static final int DEFAULT_TTL = 7200;

    private final SlionOauthClientMapper baseMapper;
    private final PasswordEncoder passwordEncoder;

    @Override
    public SlionOauthClientVo queryById(Long id) {
        SlionOauthClientVo vo = baseMapper.selectVoById(id);
        maskSecret(vo);
        return vo;
    }

    @Override
    public TableDataInfo<SlionOauthClientVo> queryPageList(SlionOauthClientBo bo, PageQuery pageQuery) {
        Page<SlionOauthClientVo> page = baseMapper.selectVoPage(pageQuery.build(), buildQueryWrapper(bo));
        page.getRecords().forEach(this::maskSecret);
        return TableDataInfo.build(page);
    }

    @Override
    public List<SlionOauthClientVo> queryList(SlionOauthClientBo bo) {
        List<SlionOauthClientVo> list = baseMapper.selectVoList(buildQueryWrapper(bo));
        list.forEach(this::maskSecret);
        return list;
    }

    @Override
    public SlionOauthClientVo insertByBo(SlionOauthClientBo bo) {
        if (!checkAppKeyUnique(bo)) {
            throw new ServiceException("AppKey 已存在：" + bo.getAppKey());
        }
        String plainKey = StringUtils.blankToDefault(bo.getAppKey(), IdUtil.fastSimpleUUID());
        String plainSecret = StringUtils.blankToDefault(bo.getAppSecret(), RandomUtil.randomString(32));
        SlionOauthClient entity = MapstructUtils.convert(bo, SlionOauthClient.class);
        entity.setAppKey(plainKey);
        entity.setAppSecret(passwordEncoder.encode(plainSecret));
        entity.setGrantTypes(StringUtils.blankToDefault(bo.getGrantTypes(), DEFAULT_GRANT));
        entity.setScopes(StringUtils.blankToDefault(bo.getScopes(), DEFAULT_SCOPE));
        entity.setAccessTokenTtl(bo.getAccessTokenTtl() == null ? DEFAULT_TTL : bo.getAccessTokenTtl());
        entity.setStatus(StringUtils.blankToDefault(bo.getStatus(), "0"));
        if (baseMapper.insert(entity) <= 0) {
            throw new ServiceException("新增开放应用失败");
        }
        SlionOauthClientVo vo = baseMapper.selectVoById(entity.getId());
        maskSecret(vo);
        vo.setAppSecretPlain(plainSecret);
        return vo;
    }

    @Override
    public Boolean updateByBo(SlionOauthClientBo bo) {
        if (!checkAppKeyUnique(bo)) {
            throw new ServiceException("AppKey 已存在：" + bo.getAppKey());
        }
        SlionOauthClient db = baseMapper.selectById(bo.getId());
        if (db == null) {
            throw new ServiceException("开放应用不存在");
        }
        SlionOauthClient entity = MapstructUtils.convert(bo, SlionOauthClient.class);
        if (StringUtils.isBlank(bo.getAppSecret())) {
            entity.setAppSecret(null);
        } else {
            entity.setAppSecret(passwordEncoder.encode(bo.getAppSecret()));
        }
        if (StringUtils.isBlank(entity.getGrantTypes())) {
            entity.setGrantTypes(DEFAULT_GRANT);
        }
        if (StringUtils.isBlank(entity.getScopes())) {
            entity.setScopes(DEFAULT_SCOPE);
        }
        return baseMapper.updateById(entity) > 0;
    }

    @Override
    public SlionOauthClientVo resetSecret(Long id) {
        SlionOauthClient db = baseMapper.selectById(id);
        if (db == null) {
            throw new ServiceException("开放应用不存在");
        }
        String plainSecret = RandomUtil.randomString(32);
        SlionOauthClient update = new SlionOauthClient();
        update.setId(id);
        update.setAppSecret(passwordEncoder.encode(plainSecret));
        baseMapper.updateById(update);
        SlionOauthClientVo vo = baseMapper.selectVoById(id);
        maskSecret(vo);
        vo.setAppSecretPlain(plainSecret);
        return vo;
    }

    @Override
    public Boolean updateStatus(Long id, String status) {
        SlionOauthClient update = new SlionOauthClient();
        update.setId(id);
        update.setStatus(status);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        return baseMapper.deleteByIds(ids) > 0;
    }

    @Override
    public boolean checkAppKeyUnique(SlionOauthClientBo bo) {
        if (StringUtils.isBlank(bo.getAppKey())) {
            return true;
        }
        long count = baseMapper.selectCount(Wrappers.<SlionOauthClient>lambdaQuery()
            .eq(SlionOauthClient::getAppKey, bo.getAppKey())
            .ne(bo.getId() != null, SlionOauthClient::getId, bo.getId()));
        return count == 0;
    }

    private LambdaQueryWrapper<SlionOauthClient> buildQueryWrapper(SlionOauthClientBo bo) {
        return Wrappers.<SlionOauthClient>lambdaQuery()
            .like(StringUtils.isNotBlank(bo.getAppName()), SlionOauthClient::getAppName, bo.getAppName())
            .eq(StringUtils.isNotBlank(bo.getAppKey()), SlionOauthClient::getAppKey, bo.getAppKey())
            .eq(StringUtils.isNotBlank(bo.getStatus()), SlionOauthClient::getStatus, bo.getStatus())
            .orderByDesc(SlionOauthClient::getId);
    }

    private void maskSecret(SlionOauthClientVo vo) {
        if (vo == null) {
            return;
        }
        vo.setAppSecret(null);
        if (Objects.isNull(vo.getAppSecretPlain())) {
            // keep null
        }
    }
}
