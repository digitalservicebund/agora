package org.agora;

import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.events.admin.OperationType;
import org.keycloak.events.admin.ResourceType;
import org.keycloak.events.EventType;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.email.DefaultEmailSenderProvider;
import org.keycloak.email.EmailException;
import org.keycloak.services.resources.LoginActionsService;
import org.keycloak.authentication.actiontoken.execactions.ExecuteActionsActionToken;
import org.keycloak.common.util.Time;

import javax.ws.rs.core.UriBuilder;
import java.util.List;

public class AgoraWelcomeProvider implements EventListenerProvider {

	private final KeycloakSession session;


	public AgoraWelcomeProvider(KeycloakSession session) {
		this.session = session;
	}

	@Override
	public void onEvent(Event event) {
	}

	@Override
	public void onEvent(AdminEvent event, boolean b) {

		if (OperationType.CREATE.equals(event.getOperationType()) && 
				ResourceType.USER.equals(event.getResourceType())) {

			String userId = event.getResourcePath().split("/")[1];
			RealmModel realm = this.session.getContext().getRealm();
			UserModel newUser = this.session.users().getUserById(userId, realm);

			// create token for initial passwort reset
			int lifespan = 2592000; // 30 * 24 * 60 * 60 seconds
			int expiration = Time.currentTime() + lifespan;
			var actions = List.of("UPDATE_PASSWORD");
			ExecuteActionsActionToken token = new ExecuteActionsActionToken(newUser.getId(), expiration, actions, "https://agora-oegd.de", "nextcloud");

			// create link
			UriBuilder builder = LoginActionsService.actionTokenProcessor(session.getContext().getUri());
      builder.queryParam("key", token.serialize(session, realm, session.getContext().getUri()));
      String link = builder.build(realm.getName()).toString();


			String emailPlainContent = "Hallo " + newUser.getFirstName() + " " + newUser.getLastName() + "," + "\n\n" + 
      													 "ein Agora-Konto wurde für Sie angelegt." + "\n\n" + 
      													 "Um die Registrierung abzuschließen, klicken Sie bitte auf den folgenden Link: " + "\n\n" + 
      													 link + "\n\n" +
      													 "Der Link ist einen Monat gültig. Sollte der Link nicht mehr gültig sein, wenden Sie sich bitte an die Administrator:innen in Ihrer Behörede bzw. Organisation." + "\n\n" + 
      													 "Agora-Kollaborationsplattform: https://agora-oegd.de" + "\n" +
      													 "Tutorials: https://einrichtung.agora-oegd.de/tutorials?utm_source=anmeldung&utm_medium=email Passwort: kollaboration" + "\n" +
      													 "Nutzer:innenverwaltung für Administrator:innen: https://agora-oegd.de/nutzerinnenverwaltung" + "\n\n" +
													 			 "Agora — die ÖGD-Kollaborationsplattform" + "\n" +
      													 "Ihre Amtsleitung hat uns gebeten, die Kollaborationsplattform Agora in Ihrem Gesundheitsamt einzurichten. Agora vereinfacht den internen, regionalen als auch länderübergreifenden Wissensaustausch und die Zusammenarbeit im Öffentlichen Gesundheitsdienst. Weitere Informationen zu Agora finden Sie unter: https://einrichtung.agora-oegd.de/?utm_source=anmeldung&utm_medium=email (Passwort: kollaboration)" + "\n\n" + 
      													 "Viele Grüße" + "\n" +
      													 "Ihr Agora-Team";

      String emailHtmlContent = "<h2>Hallo " + newUser.getFirstName() + " " + newUser.getLastName() + ",</h2>" + 
      													"<p>ein Agora-Konto wurde für Sie angelegt. Um die Registrierung abzuschließen, klicken Sie bitte auf den folgenden Link:</p>" + 
      													"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin: 2.3em 0;\"><tr><td align=\"center\"><a href=\"" + link + "\" style=\"display: box; color: white; font-size: 1.1em; background-color: #003F97; padding: 12px 70px; text-decoration: none; border-radius: 10px;\">Für Agora Registrieren</a></td></tr></table>" + 
      													"<p>Der Link ist einen Monat gültig. Sollte der Link nicht mehr gültig sein, wenden Sie sich bitte an die Administrator:innen in Ihrer Behörede bzw. Organisation.</p>" + 
      													"<ul><li>Agora-Kollaborationsplattform: <a href=\"https://agora-oegd.de\">agora-oegd.de</a></li>" + 
      													"<li>Tutorials: <a href=\"https://einrichtung.agora-oegd.de/tutorials?utm_source=anmeldung&utm_medium=email\">einrichtung.agora-oegd.de/tutorials</a> Passwort: <u>kollaboration</u></li>" + 
      													"<li>Nutzer:innenverwaltung für Administrator:innen: <a href=\"https://agora-oegd.de/nutzerinnenverwaltung\">agora-oegd.de/nutzerinnenverwaltung</a></li></ul>" +
      													"<p><b>Agora — die ÖGD-Kollaborationsplattform</b><br />" + 
      													"Ihre Amtsleitung hat uns gebeten, die Kollaborationsplattform Agora in Ihrem Gesundheitsamt einzurichten. Agora vereinfacht den internen, regionalen als auch länderübergreifenden Wissensaustausch und die Zusammenarbeit im Öffentlichen Gesundheitsdienst. Weitere Informationen zu Agora finden Sie unter: <a href=\"https://einrichtung.agora-oegd.de/agora?utm_source=Presentation&utm_medium=social\">einrichtung.agora-oegd.de</a> Passwort: <u>kollaboration</u>.</p>" + 
	      												"<p>Viele Grüße<br />" + 
      													"Ihr Agora-Team</p>";

      
			DefaultEmailSenderProvider senderProvider = new DefaultEmailSenderProvider(session);
      try {
          senderProvider.send(realm.getSmtpConfig(), newUser, "Agora-Registrierungslink", emailPlainContent, null);
      } catch (EmailException e) {
          System.out.println("Failed to send welcome email");
      }

		}

	}

	@Override
	public void close() {

	}
}
