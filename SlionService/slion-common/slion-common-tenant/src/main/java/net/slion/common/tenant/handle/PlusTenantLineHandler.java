package net.slion.common.tenant.handle;

import cn.hutool.core.collection.ListUtil;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.StringValue;
import net.slion.common.core.exception.ServiceException;
import net.slion.common.core.utils.StringUtils;
import net.slion.common.tenant.helper.TenantHelper;
import net.slion.common.tenant.properties.TenantProperties;

import java.util.List;

/**
 * 自定义租户处理器
 *
 * @author Lion Li
 */
@Slf4j
@AllArgsConstructor
public class PlusTenantLineHandler implements TenantLineHandler {

    private final TenantProperties tenantProperties;

    @Override
    public Expression getTenantId() {
        String tenantId = TenantHelper.getTenantId();
        if (StringUtils.isBlank(tenantId)) {
            log.error("无法获取有效的租户id，拒绝拼接租户条件");
            throw new ServiceException("无法获取有效的租户id");
        }
        return new StringValue(tenantId);
    }

    @Override
    public boolean ignoreTable(String tableName) {
        // 租户功能关闭时由 TenantConfig 不装配本 Handler；此处仅处理开启态
        if (!TenantHelper.isEnable()) {
            return true;
        }
        String tenantId = TenantHelper.getTenantId();
        if (StringUtils.isBlank(tenantId)) {
            // 无租户上下文时跳过业务表租户条件，由上层鉴权保证；排除表始终忽略
            List<String> excludes = tenantProperties.getExcludes();
            List<String> tables = ListUtil.toList("gen_table", "gen_table_column");
            tables.addAll(excludes);
            return StringUtils.equalsAnyIgnoreCase(tableName, tables.toArray(new String[0]))
                || isNonBusinessTable(tableName);
        }
        List<String> excludes = tenantProperties.getExcludes();
        List<String> tables = ListUtil.toList("gen_table", "gen_table_column");
        tables.addAll(excludes);
        return StringUtils.equalsAnyIgnoreCase(tableName, tables.toArray(new String[0]));
    }

    private boolean isNonBusinessTable(String tableName) {
        return StringUtils.startWithAnyIgnoreCase(tableName, "sj_", "qrtz_");
    }

}
