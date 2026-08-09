package net.slion.common.tenant.handle;

import cn.hutool.core.collection.ListUtil;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.NullValue;
import net.sf.jsqlparser.expression.StringValue;
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
            // 登录监听等场景可能尚未写入租户上下文；交给 ignoreTable 跳过，避免阻断登录
            log.warn("无法获取有效的租户id，返回 NullValue（应由 ignoreTable 忽略该表）");
            return new NullValue();
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
        // 无租户上下文（登录写回、定时任务等）：跳过全部租户条件
        if (StringUtils.isBlank(tenantId)) {
            return true;
        }
        List<String> excludes = tenantProperties.getExcludes();
        List<String> tables = ListUtil.toList("gen_table", "gen_table_column");
        tables.addAll(excludes);
        return StringUtils.equalsAnyIgnoreCase(tableName, tables.toArray(new String[0]))
            || isNonBusinessTable(tableName);
    }

    private boolean isNonBusinessTable(String tableName) {
        return StringUtils.startWithAnyIgnoreCase(tableName, "sj_", "qrtz_");
    }

}
