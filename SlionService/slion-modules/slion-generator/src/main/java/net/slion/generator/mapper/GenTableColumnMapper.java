package net.slion.generator.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import net.slion.common.mybatis.core.mapper.BaseMapperPlus;
import net.slion.generator.domain.GenTableColumn;

/**
 * 业务字段 数据层
 *
 * @author Lion Li
 */
@InterceptorIgnore(dataPermission = "true", tenantLine = "true")
public interface GenTableColumnMapper extends BaseMapperPlus<GenTableColumn, GenTableColumn> {

}
