package net.slion.workflow.controller;

import lombok.RequiredArgsConstructor;
import net.slion.common.core.domain.R;
import net.slion.common.web.core.BaseController;
import net.slion.workflow.common.ConditionalOnEnable;
import net.slion.workflow.config.WorkflowFeatureProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 工作流功能开关查询（前端按需展示转办/委派/撤销等）
 */
@ConditionalOnEnable
@RequiredArgsConstructor
@RestController
@RequestMapping("/workflow/feature")
public class FlwFeatureController extends BaseController {

    private final WorkflowFeatureProperties featureProperties;

    @GetMapping("/flags")
    public R<WorkflowFeatureProperties> flags() {
        return R.ok(featureProperties);
    }
}
