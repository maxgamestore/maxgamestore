import java.io.*;
import java.net.*;
import java.util.zip.*;

public class BootLoader {
    public static void main(String[] args) {
        try {
            System.out.println("========================================");
            System.out.println("  WORLD OF FIGHTS - BOOTLOADER");
            System.out.println("========================================\n");
            
            System.out.println("📥 Downloading game from server...");
            
            // ÎNLOCOUIEȘTE CU IP-UL SERVERULUI TĂU REAL
            String serverUrl = "http://localhost:3001/download-client";
            
            URL url = new URL(serverUrl);
            try (InputStream in = url.openStream();
                 FileOutputStream fos = new FileOutputStream("game.zip")) {
                byte[] buffer = new byte[8192];
                int len;
                int total = 0;
                while ((len = in.read(buffer)) != -1) {
                    fos.write(buffer, 0, len);
                    total += len;
                }
                System.out.println("   Downloaded: " + total + " bytes");
            }
            
            System.out.println("📦 Extracting files...");
            try (ZipInputStream zis = new ZipInputStream(new FileInputStream("game.zip"))) {
                ZipEntry entry;
                while ((entry = zis.getNextEntry()) != null) {
                    File file = new File(entry.getName());
                    if (entry.isDirectory()) {
                        file.mkdirs();
                    } else {
                        file.getParentFile().mkdirs();
                        try (FileOutputStream fos = new FileOutputStream(file)) {
                            byte[] buffer = new byte[8192];
                            int len;
                            while ((len = zis.read(buffer)) != -1) {
                                fos.write(buffer, 0, len);
                            }
                        }
                    }
                    zis.closeEntry();
                }
            }
            
            System.out.println("⚙️ Compiling game...");
            ProcessBuilder pb = new ProcessBuilder("javac", "clientfiles/com/worldoffights/client/*.java");
            pb.redirectErrorStream(true);
            Process compile = pb.start();
            
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(compile.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }
            }
            
            int exitCode = compile.waitFor();
            if (exitCode != 0) {
                System.err.println("❌ Compilation failed!");
                System.out.println("\nPress Enter to exit...");
                System.in.read();
                return;
            }
            
            System.out.println("✅ Compilation successful!\n");
            System.out.println("🎮 Starting World Of Fights...\n");
            
            ProcessBuilder pbRun = new ProcessBuilder("java", "-cp", "clientfiles", "com.worldoffights.client.Main");
            pbRun.inheritIO();
            pbRun.start();
            
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
            System.out.println("\nPress Enter to exit...");
            try { System.in.read(); } catch(Exception ex) {}
        }
    }
}
