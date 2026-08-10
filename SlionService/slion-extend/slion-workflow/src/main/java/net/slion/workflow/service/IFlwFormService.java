package net.slion.workflow.service;

import net.slion.common.mybatis.core.page.PageQuery;
import net.slion.common.mybatis.core.page.TableDataInfo;
import org.dromara.warm.flow.orm.entity.FlowForm;

import java.util.Collection;
import java.util.List;

/**
 * 流程表单
 */
public interface IFlwFormService {

    TableDataInfo<FlowForm> queryPageList(FlowForm form, PageQuery pageQuery);

    FlowForm queryById(Long id);

    Boolean insertForm(FlowForm form);

    Boolean updateForm(FlowForm form);

    Boolean deleteByIds(Collection<Long> ids);

    Boolean publish(Long id);

    Boolean unPublish(Long id);

    Boolean copyForm(Long id);

    Boolean saveContent(Long id, String formContent);

    List<FlowForm> listPublished(String formName);
}
