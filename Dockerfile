FROM oracle/graalvm-ce:1.0.0-rc10
EXPOSE 8080
COPY target/christmas-tree-animation-rainbow-*.jar christmas-tree-animation-rainbow.jar
ADD . target
RUN java -cp christmas-tree-animation-rainbow.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer \
    && native-image --no-server \
             --allow-incomplete-classpath \
             --class-path christmas-tree-animation-rainbow.jar \
             --report-unsupported-elements-at-runtime \
             -H:ReflectionConfigurationFiles=target/reflect.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml|META-INF/services/*.*|.*.png" \
             -H:Name=christmas-tree-animation-rainbow \
             -H:Class=nl.pvanassen.christmas.tree.animation.rainbow.Application \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:+AllowVMInspection \
             -H:-UseServiceLoaderFeature \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient,io.netty.handler.ssl.ReferenceCountedOpenSslEngine,io.netty.handler.ssl.JdkNpnApplicationProtocolNegotiator,io.netty.handler.ssl.util.BouncyCastleSelfSignedCertGenerator

ENTRYPOINT ["./christmas-tree-animation-rainbow", "-Djava.awt.headless=true"]

