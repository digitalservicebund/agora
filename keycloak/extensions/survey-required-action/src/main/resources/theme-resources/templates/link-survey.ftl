<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header">
        Umfrage zur ÖGD-weiten Kollaboration
    <#elseif section = "form">
    <div id="kc-survey-text">
        <div style="margin-bottom: 20px">
            Wir würden gerne mehr über Sie und Ihre Zufriedenheit mit der instutionsübergreifenden Zusammenarbeit im ÖGD erfahren. Mit Ihrer Teilnahme helfen Sie uns, bessere Lösungen zu entwickeln.
        </div>
        <div style="margin-bottom: 20px">
            Die Umfrage dauert nur wenige Minuten und Ihre Teilname ist anonym.
        </div>
        <div style="margin-bottom: 10px">
            <a href="https://docs.google.com/forms/d/e/1FAIpQLSfdbSWxSs_124xYq_7Jx_dx5SdLSMlcL4bRKQjp7wo5bA2iew/viewform" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" target="_blank">
                An der Umfrage teilnehmen
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