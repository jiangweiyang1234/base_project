package net.slion.workflow.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import net.slion.common.core.exception.ServiceException;
import net.slion.common.core.utils.StringUtils;
import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import net.slion.workflow.common.ConditionalOnEnable;
import net.slion.workflow.service.IFlwFormService;
import org.dromara.warm.flow.core.enums.PublishStatus;
import org.dromara.warm.flow.core.service.FormService;
import org.dromara.warm.flow.orm.entity.FlowForm;
import org.dromara.warm.flow.orm.mapper.FlowFormMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * 流程表单
 */
@ConditionalOnEnable
@RequiredArgsConstructor
@Service
public class FlwFormServiceImpl implements IFlwFormService {

    private final FormService formService;
    private final FlowFormMapper flowFormMapper;

    @Override
    public TableDataInfo<FlowForm> queryPageList(FlowForm form, PageQuery pageQuery) {
        LambdaQueryWrapper<FlowForm> lqw = buildQueryWrapper(form);
        Page<FlowForm> page = flowFormMapper.selectPage(pageQuery.build(), lqw);
        return TableDataInfo.build(page);
    }

    @Override
    public FlowForm queryById(Long id) {
        return flowFormMapper.selectById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertForm(FlowForm form) {
        if (form.getIsPublish() == null) {
            form.setIsPublish(PublishStatus.UNPUBLISHED.getKey());
        }
        if (form.getFormType() == null) {
            form.setFormType(0);
        }
        return formService.save(form);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateForm(FlowForm form) {
        FlowForm db = flowFormMapper.selectById(form.getId());
        if (db == null) {
            throw new ServiceException("表单不存在");
        }
        if (PublishStatus.PUBLISHED.getKey().equals(db.getIsPublish())) {
            throw new ServiceException("已发布表单不可直接修改，请先取消发布");
        }
        return formService.updateById(form);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteByIds(Collection<Long> ids) {
        for (Long id : ids) {
            FlowForm db = flowFormMapper.selectById(id);
            if (db != null && PublishStatus.PUBLISHED.getKey().equals(db.getIsPublish())) {
                throw new ServiceException("存在已发布表单，无法删除：" + db.getFormName());
            }
        }
        return formService.removeByIds(ids);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean publish(Long id) {
        return formService.publish(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean unPublish(Long id) {
        return formService.unPublish(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean copyForm(Long id) {
        return formService.copyForm(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveContent(Long id, String formContent) {
        return formService.saveContent(id, formContent);
    }

    @Override
    public List<FlowForm> listPublished(String formName) {
        FlowForm query = new FlowForm();
        query.setIsPublish(PublishStatus.PUBLISHED.getKey());
        if (StringUtils.isNotBlank(formName)) {
            query.setFormName(formName);
        }
        return flowFormMapper.selectList(buildQueryWrapper(query));
    }

    private LambdaQueryWrapper<FlowForm> buildQueryWrapper(FlowForm form) {
        return Wrappers.lambdaQuery(FlowForm.class)
            .like(StringUtils.isNotBlank(form.getFormCode()), FlowForm::getFormCode, form.getFormCode())
            .like(StringUtils.isNotBlank(form.getFormName()), FlowForm::getFormName, form.getFormName())
            .eq(ObjectUtil.isNotNull(form.getIsPublish()), FlowForm::getIsPublish, form.getIsPublish())
            .eq(ObjectUtil.isNotNull(form.getFormType()), FlowForm::getFormType, form.getFormType())
            .orderByDesc(FlowForm::getCreateTime)
            .orderByDesc(FlowForm::getId);
    }
}
