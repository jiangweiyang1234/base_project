package net.slion.common.translation.core.impl;

import cn.hutool.core.convert.Convert;
import lombok.AllArgsConstructor;
import net.slion.common.core.service.UserService;
import net.slion.common.translation.annotation.TranslationType;
import net.slion.common.translation.constant.TransConstant;
import net.slion.common.translation.core.TranslationInterface;

/**
 * 用户名翻译实现
 *
 * @author Lion Li
 */
@AllArgsConstructor
@TranslationType(type = TransConstant.USER_ID_TO_NAME)
public class UserNameTranslationImpl implements TranslationInterface<String> {

    private final UserService userService;

    @Override
    public String translation(Object key, String other) {
        return userService.selectUserNameById(Convert.toLong(key));
    }
}
