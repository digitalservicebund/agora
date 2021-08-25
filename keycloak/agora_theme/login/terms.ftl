<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        Nutzungsbedingungen
    <#elseif section = "form">
    <div id="kc-terms-text">
        Um Agora nutzen zu können, müssen Sie die Nutzungsbedingungen zur Kenntnis nehmen und akzeptieren. Die Nutzungsbedingungen beschreiben u.a. den Zugang zu Agora, den Registrierungsprozess, das Teilen von Daten, das Rollen- und Rechtekonzept, die Mitwirkungspflichten, die Auswirkung von Pflichtverletzungen und Hinweise zum Betrieb:
        
        <a href="https://agora-oegd.de/s/sD8NBTEsytJ6Agq" target="_blank">Agora Nutzungsbedingungen</a>.
    </div>
    <form class="form-actions" action="${url.loginAction}" method="POST">
        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>