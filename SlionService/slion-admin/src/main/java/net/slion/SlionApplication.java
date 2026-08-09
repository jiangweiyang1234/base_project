package net.slion;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.metrics.buffering.BufferingApplicationStartup;

/**
 * 启动程序
 *
 * @author Lion Li
 */

@SpringBootApplication(scanBasePackages = "net.slion")
@Slf4j
public class SlionApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(SlionApplication.class);
        application.setApplicationStartup(new BufferingApplicationStartup(2048));
        application.run(args);
        log.info("Slion-Service instance start successful !!!");
    }

}
