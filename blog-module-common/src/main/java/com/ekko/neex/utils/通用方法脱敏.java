package com.ekko.neex.utils;

/**
 * 通用方法脱敏
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
public class 通用方法脱敏 {

    /**
     * 通用脱敏方法
     *
     * @param input      原始字符串
     * @param prefixLen  保留的前缀长度
     * @param suffixLen  保留的后缀长度
     * @param maskChar   替换的字符
     * @param maskLength 替换的长度
     * @return 脱敏后的字符串
     */
    public static String desensitize(String input, int prefixLen, int suffixLen, char maskChar, int maskLength) {
        if (input == null || input.length() < prefixLen + suffixLen - 1) {
            return input;
        }
        String prefix = input.substring(0, prefixLen);
        String suffix = input.substring(input.length() - suffixLen);
        String mask = new String(new char[maskLength]).replace('\0', maskChar);
        return prefix + mask + suffix;
    }
}
