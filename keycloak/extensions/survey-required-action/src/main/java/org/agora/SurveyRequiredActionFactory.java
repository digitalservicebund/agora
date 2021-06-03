package org.agora;

import org.keycloak.authentication.DisplayTypeRequiredActionFactory;
import org.keycloak.authentication.RequiredActionFactory;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.Config;

public class SurveyRequiredActionFactory implements RequiredActionFactory, DisplayTypeRequiredActionFactory {

	@Override
	public RequiredActionProvider create(KeycloakSession session) {
			return new SurveyRequiredAction(session);
	}

	@Override
	public RequiredActionProvider createDisplay(KeycloakSession session, String displayType) {
			return create(session);
	}

	@Override
	public void init(Config.Scope config) {

	}

	@Override
	public void postInit(KeycloakSessionFactory factory) {

	}

	@Override
	public void close() {

	}

	@Override
	public String getId() {
			return SurveyRequiredAction.ID;
	}

	@Override
	public String getDisplayText() {
			return "Show link to survey";
	}

	@Override
	public boolean isOneTimeAction() {
			return true;
	}
}
