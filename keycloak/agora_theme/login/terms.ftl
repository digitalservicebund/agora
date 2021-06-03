<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        Nutzungsbedingungen
    <#elseif section = "form">
    <div id="kc-terms-text">
        Bitte nehmem Sie die folgenden Nutzungsbedingungen zur Kenntnis und akzeptieren Sie sie, um fortzufahren:
        
        <a href="https://agora-oegd.de/s/8RZBT49qGsdScRm/download/Nutzungsbedingungen_Agora_%C3%96GD_1.0.pdf" target="_blank">Agora Nutzungsbedingungen</a>.
    </div>
    <form class="form-actions" action="${url.loginAction}" method="POST">
        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
        <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="cancel" id="kc-decline" type="submit" value="${msg("doDecline")}"/>
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>