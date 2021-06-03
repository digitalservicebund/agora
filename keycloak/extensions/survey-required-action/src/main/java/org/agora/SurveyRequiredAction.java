package org.agora;

import org.keycloak.authentication.InitiatedActionSupport;
import org.keycloak.authentication.RequiredActionContext;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;

public class SurveyRequiredAction implements RequiredActionProvider {

	@Override
	public InitiatedActionSupport initiatedActionSupport() {
			return InitiatedActionSupport.SUPPORTED;
	}

	@Override
	public void evaluateTriggers(RequiredActionContext context) {

	}

	@Override
	public void requiredActionChallenge(RequiredActionContext context) {

	}

	@Override
	public void processAction(RequiredActionContext context) {

	}

	@Override
	public void close() {

	}

}