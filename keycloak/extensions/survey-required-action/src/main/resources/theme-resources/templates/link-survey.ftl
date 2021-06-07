<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header">
        Umfrage zur ÖGD-weiten Kollaboration
    <#elseif section = "form">
    <div id="kc-survey-text">
        <p>Um Agora weiter verbessern zu können, brauchen wir Ihren Input. Bitte nehmen Sie an der folgenden Umfrage teil: <a href="https://docs.google.com/forms/d/e/1FAIpQLSfdbSWxSs_124xYq_7Jx_dx5SdLSMlcL4bRKQjp7wo5bA2iew/viewform">teilnehmen</a></p>
    </div>
    <form class="form-actions" action="${url.loginAction}" method="POSt">
        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="Weiter"/>
    </form>        
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>