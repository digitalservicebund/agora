<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header">
        Quantitative und anonyme Umfrage zur ÖGD-weiten Kollaboration vor der Nutzung von Agora
    <#elseif section = "form">
    <div id="kc-survey-text">
        <div style="margin-bottom: 20px">
            Die Umfrage dauert ca. 2 Minuten. Ihre Teilname ist anonym und optional.
        </div>
        <div style="margin-bottom: 20px">
            Um zu messen, inwieweit Agora die Kollaboration im ÖGD fördert, möchten wir gerne mehr über Ihre Zufriedenheit im ÖGD erfahren. Eine zweite Umfrage in einigen Monaten ermöglicht es uns, die Ergebnisse vor und nach der Einführung von Agora zu vergleichen.
        </div>
        <div style="margin-bottom: 10px">
            <a href="https://docs.google.com/forms/d/e/1FAIpQLSfdbSWxSs_124xYq_7Jx_dx5SdLSMlcL4bRKQjp7wo5bA2iew/viewform" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" target="_blank">
                An kurzer Umfrage teilnehmen
            </a>
        </div>
    </div>
    <div>
        <form class="form-actions" action="${url.loginAction}" method="POST">
            <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="Weiter zu Agora"/>
        </form>        
    </div>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
