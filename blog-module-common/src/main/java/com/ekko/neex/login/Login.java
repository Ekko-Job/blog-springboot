package com.ekko.neex.login;

import cn.hutool.core.codec.Base64;
import cn.hutool.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.swing.*;
import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Login
 *
 * @author Ekko
 * @date 2025-04-17
 * @email ekko.zhang@unionftech.com
 */
@RestController
@RequestMapping("/Login")
public class Login {

    public static void main(String[] args) throws Exception {
        showAccessTokenDialog();
    }

    @RequestMapping("/login")
    private static Map<String, Object> extracted(String username, String password, boolean generateCP, boolean generateIntegral, String mallnum) throws Exception {
        Map<String, Object> tokens = new LinkedHashMap<>();
        if (generateCP) {
            JSONObject jsonResponse = getJsonObject(username, password);
            tokens.put("——CP_PublicKey", getPublicKey());
            tokens.put("——CP_PassWord", publicEncryptString(password, getPublicKey()));
            tokens.put("——CP_ACCESS_Token", jsonResponse.getStr("access_token"));
        }
        if (generateIntegral) {
            JSONObject MWSgetJsonObject = MWSgetJsonObject(username, password, mallnum);  // 传递mallnum
            tokens.put("——Integral_PublicKey", MWSgetPublicKey());
            tokens.put("——Integral_PassWord", publicEncryptString(password, MWSgetPublicKey()));
            tokens.put("——Integral_ACCESS_Token", MWSgetJsonObject.getStr("data"));
        }
        return tokens;
    }

    private static JSONObject getJsonObject(String username, String password) throws Exception {
        URL url = new URL("http://localhost:9002/fore/auth/login");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        conn.setDoOutput(true);

        String formData = "username=" + URLEncoder.encode(username, "UTF-8") +
                "&password=" + URLEncoder.encode(publicEncryptString(password, getPublicKey()), "UTF-8") +
                "&loginType=" + URLEncoder.encode("2", "UTF-8") +
                "&verifyType=" + URLEncoder.encode("1", "UTF-8") +
                "&timestamp=" + URLEncoder.encode(String.valueOf(System.currentTimeMillis()), "UTF-8");

        try (OutputStream os = conn.getOutputStream()) {
            os.write(formData.getBytes(StandardCharsets.UTF_8));
            os.flush();
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
        }
        return new JSONObject(response.toString());
    }

    private static JSONObject MWSgetJsonObject(String username, String password, String mallnum) throws Exception {
        URL url = new URL("http://localhost:83/integral/front/login");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("mallnum", mallnum);  // 使用用户输入的mallnum
        conn.setRequestProperty("language", "zh-CN");
        conn.setDoOutput(true);

        JSONObject jsonBody = new JSONObject();
        jsonBody.put("loginEmail", username);
        jsonBody.put("password", publicEncryptString(password, MWSgetPublicKey()));
        jsonBody.put("recaptcha", "123");

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonBody.toString().getBytes(StandardCharsets.UTF_8));
            os.flush();
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
        }
        return new JSONObject(response.toString());
    }

    private static void showAccessTokenDialog() {
        JFrame frame = new JFrame("登录成功");
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setAlwaysOnTop(true);
        frame.setResizable(false);
        frame.setSize(400, 180);

        JPanel panel = new JPanel();
        panel.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JTextField usernameField = new JTextField(15);
        JPasswordField passwordField = new JPasswordField(15);
        passwordField.setText("Aa123456");  // 默认密码设置为 "Aa123456"
        JCheckBox cpCheckbox = new JCheckBox("生成CP数据");
        JCheckBox integralCheckbox = new JCheckBox("生成Integral数据");

        // 添加mallnum输入框
        JTextField mallnumField = new JTextField(15);
        mallnumField.setText("bded741441e442c48b70a44a86a1d02e");  // 默认值

        gbc.gridx = 0;
        gbc.gridy = 0;
        panel.add(new JLabel("账号:"), gbc);
        gbc.gridx = 1;
        panel.add(usernameField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 1;
        panel.add(new JLabel("密码:"), gbc);
        gbc.gridx = 1;
        panel.add(passwordField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 2;
        panel.add(cpCheckbox, gbc);
        gbc.gridx = 0;
        gbc.gridy = 3;
        panel.add(integralCheckbox, gbc);

        gbc.gridx = 0;
        gbc.gridy = 4;
        panel.add(new JLabel("mallnum(Ekko商城):"), gbc);
        gbc.gridx = 1;
        panel.add(mallnumField, gbc);

        JButton generateButton = new JButton("生成");
        generateButton.addActionListener(e -> {
            try {
                String username = usernameField.getText();
                String password = new String(passwordField.getPassword());

                // 如果没有输入自定义密码，使用默认密码
                if (password.isEmpty()) {
                    password = "Aa123456";
                }

                boolean generateCP = cpCheckbox.isSelected();
                boolean generateIntegral = integralCheckbox.isSelected();

                String mallnum = mallnumField.getText();  // 获取用户输入的mallnum
                if (mallnum.isEmpty()) {
                    mallnum = "bded741441e442c48b70a44a86a1d02e";  // 如果没输入，使用默认值
                }

                Map<String, Object> tokens = extracted(username, password, generateCP, generateIntegral, mallnum);
                showGeneratedTokensDialog(tokens);
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, "生成失败: " + ex.getMessage());
            }
        });

        gbc.gridx = 0;
        gbc.gridy = 5;
        gbc.gridwidth = 2;
        panel.add(generateButton, gbc);

        frame.add(panel);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private static void showGeneratedTokensDialog(Map<String, Object> tokens) {
        JFrame tokenFrame = new JFrame("生成的Token");
        tokenFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        tokenFrame.setAlwaysOnTop(true);
        tokenFrame.setSize(500, 200);

        JPanel panel = new JPanel();
        panel.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.HORIZONTAL;
        int row = 0;

        for (Map.Entry<String, Object> entry : tokens.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue().toString();

            gbc.gridx = 0;
            gbc.gridy = row;
            gbc.weightx = 0.5;
            gbc.anchor = GridBagConstraints.WEST;
            JLabel nameLabel = new JLabel(key);
            panel.add(nameLabel, gbc);

            gbc.gridx = 1;
            gbc.weightx = 1;
            gbc.anchor = GridBagConstraints.CENTER;
            String displayValue = value.length() > 20 ? value.substring(0, 20) + "..." : value;
            JLabel valueLabel = new JLabel(displayValue);
            panel.add(valueLabel, gbc);

            gbc.gridx = 2;
            gbc.weightx = 0.5;
            gbc.anchor = GridBagConstraints.EAST;
            JButton copyButton = new JButton("复制");
            copyButton.addActionListener(e -> {
                StringSelection stringSelection = new StringSelection(value);
                Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
                clipboard.setContents(stringSelection, null);
            });
            panel.add(copyButton, gbc);

            row++;
        }

        tokenFrame.add(new JScrollPane(panel));
        tokenFrame.setLocationRelativeTo(null);
        tokenFrame.setVisible(true);
    }

    static String getPublicKey() throws Exception {
        HttpURLConnection conn = (HttpURLConnection) new URL("http://localhost:9002/fore/user/trader/getPublicKey").openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            return new JSONObject(in.lines().reduce("", (accumulator, currentLine) -> accumulator + currentLine)).getStr("data");
        }
    }

    static String MWSgetPublicKey() throws Exception {
        HttpURLConnection conn = (HttpURLConnection) new URL("http://localhost:83/integral/front/getPublicKey").openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("mallnum", "bded741441e442c48b70a44a86a1d02e");
        conn.setRequestProperty("language", "zh-CN");
        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            return new JSONObject(in.lines().reduce("", (accumulator, currentLine) -> accumulator + currentLine)).getStr("data");
        }
    }

    public static String publicEncryptString(String plainText, String publicKeyStr) throws NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, BadPaddingException, InvalidKeyException, InvalidKeySpecException {
        PublicKey publicKey = string2PublicKey(publicKeyStr);
        byte[] bytes = publicEncrytype(plainText.getBytes(StandardCharsets.UTF_8), publicKey);
        return java.util.Base64.getEncoder().encodeToString(bytes);
    }

    private static final String KEY_ALGORITHM = "RSA";
    private static final int MAX_ENCRYPT_BLOCK = 117;

    public static byte[] publicEncrytype(byte[] content, PublicKey publicKey) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        Cipher cipher = Cipher.getInstance(KEY_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        int inputLength = content.length;
        int offSet = 0;
        byte[] resultBytes = {};
        byte[] cache = {};
        while (inputLength - offSet > 0) {
            if (inputLength - offSet > MAX_ENCRYPT_BLOCK) {
                cache = cipher.doFinal(content, offSet, MAX_ENCRYPT_BLOCK);
                offSet += MAX_ENCRYPT_BLOCK;
            } else {
                cache = cipher.doFinal(content, offSet, inputLength - offSet);
                offSet = inputLength;
            }
            resultBytes = Arrays.copyOf(resultBytes, resultBytes.length + cache.length);
            System.arraycopy(cache, 0, resultBytes, resultBytes.length - cache.length, cache.length);
        }
        return resultBytes;
    }

    public static PublicKey string2PublicKey(String pubStr) throws NoSuchAlgorithmException, InvalidKeySpecException {
        byte[] bytes = Base64.decode(pubStr);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(bytes);
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
        PublicKey publicKey = keyFactory.generatePublic(keySpec);
        return publicKey;
    }
}

