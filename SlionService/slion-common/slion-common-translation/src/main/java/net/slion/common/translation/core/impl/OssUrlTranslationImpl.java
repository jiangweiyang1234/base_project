package net.slion.common.translation.core.impl;

import lombok.AllArgsConstructor;
import net.slion.common.core.service.OssService;
import net.slion.common.translation.annotation.TranslationType;
import net.slion.common.translation.constant.TransConstant;
import net.slion.common.translation.core.TranslationInterface;

/**
 * OSS翻译实现
 *
 * @author Lion Li
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.OSS_ID_TO_URL)
public class OssUrlTranslationImpl implements TranslationInterface<String> {

    private final OssService ossService;

    @Override
    public String translation(Object key, String other) {
        if (key instanceof String ids) {
            return ossService.selectUrlByIds(ids);
        } else if (key instanceof Long id) {
            return ossService.selectUrlByIds(id.toString());
        }
        return null;
    }
}
