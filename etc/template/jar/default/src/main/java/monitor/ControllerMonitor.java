package ${{package}}.monitor;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ControllerMonitor {

    private Logger getLogger(JoinPoint joinPoint) {
        return LoggerFactory.getLogger(joinPoint.getSignature().getDeclaringTypeName());
    }

    @Pointcut("within(${{package}}.controller..*) || within(${{package}}.controller.*.*)")
    public void applicationPointCut() {
        // Method is empty as this is just a Pointcut, the implementations are in the method annotated @Around.
    }

    /**
     * Log around a controller. Allow to see if whether an exception occurred during execution.
     *
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("applicationPointCut()")
    public Object log(ProceedingJoinPoint joinPoint) throws Throwable {
        Logger log = getLogger(joinPoint);
        log.debug("Enter: {}()", joinPoint.getSignature().getName());
        try {
            Object result = joinPoint.proceed();
            log.debug("Exit: {}()", joinPoint.getSignature().getName());
            return result;
        } catch (IllegalArgumentException e) {
            log.error("Error in {}()", joinPoint.getSignature().getName());
            throw e;
        }
    }

}
