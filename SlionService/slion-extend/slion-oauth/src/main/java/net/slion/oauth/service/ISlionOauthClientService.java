package net.slion.oauth.service;

import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import net.slion.oauth.domain.bo.SlionOauthClientBo;
import net.slion.oauth.domain.vo.SlionOauthClientVo;

import java.util.Collection;
import java.util.List;

/**
 * OAuth2 开放应用 Service
 */
public interface ISlionOauthClientService {

    SlionOauthClientVo queryById(Long id);

    TableDataInfo<SlionOauthClientVo> queryPageList(SlionOauthClientBo bo, PageQuery pageQuery);

    List<SlionOauthClientVo> queryList(SlionOauthClientBo bo);

    /**
     * 新增，返回含明文 AppSecret（仅此一次）
     */
    SlionOauthClientVo insertByBo(SlionOauthClientBo bo);

    Boolean updateByBo(SlionOauthClientBo bo);

    /**
     * 重置密钥，返回新明文
     */
    SlionOauthClientVo resetSecret(Long id);

    Boolean updateStatus(Long id, String status);

    Boolean deleteWithValidByIds(Collection<Long> ids);

    boolean checkAppKeyUnique(SlionOauthClientBo bo);
}
