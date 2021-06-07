package org.agora;

import org.keycloak.authentication.RequiredActionFactory;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.Config;

public class SurveyRequiredActionFactory implements RequiredActionFactory {

	@Override
  public String getDisplayText() {
      return "New User Survey";
  }

	@Override
	public RequiredActionProvider create(KeycloakSession keycloakSession) {
			return new SurveyRequiredAction(keycloakSession);
	}

	@Override
	public void init(Config.Scope scope) {

	}

	@Override
	public void postInit(KeycloakSessionFactory keycloakSessionFactory) {

	}

	@Override
	public void close() {

	}

	@Override
	public String getId() {
		return "survey_required_action";
	}
}