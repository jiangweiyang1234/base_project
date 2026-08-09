package net.slion.common.core.utils.file;

import net.slion.common.core.exception.ServiceException;
import net.slion.common.core.utils.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Arrays;
import java.util.Locale;

/**
 * 上传文件类型校验
 */
public final class FileTypeUtils {

    private FileTypeUtils() {
    }

    public static void assertAllowed(MultipartFile file, String[] allowedExtension) {
        if (file == null || file.isEmpty()) {
            throw new ServiceException("上传文件不能为空");
        }
        String originalFilename = file.getOriginalFilename();
        assertAllowedName(originalFilename, allowedExtension);
    }

    public static void assertAllowed(File file, String[] allowedExtension) {
        if (file == null || !file.isFile() || file.length() <= 0) {
            throw new ServiceException("上传文件不能为空");
        }
        assertAllowedName(file.getName(), allowedExtension);
    }

    public static void assertAllowedName(String filename, String[] allowedExtension) {
        if (StringUtils.isBlank(filename) || filename.contains("..") || filename.contains("/") || filename.contains("\\")) {
            throw new ServiceException("文件名非法");
        }
        String extension = getExtension(filename);
        if (StringUtils.isBlank(extension) || Arrays.stream(allowedExtension)
            .noneMatch(ext -> ext.equalsIgnoreCase(extension))) {
            throw new ServiceException("文件格式不正确，允许格式：" + Arrays.toString(allowedExtension));
        }
    }

    public static String getExtension(String filename) {
        if (StringUtils.isBlank(filename) || !filename.contains(".")) {
            return "";
        }
        return filename.substring(filename.lastIndexOf('.') + 1).toLowerCase(Locale.ROOT);
    }
}
