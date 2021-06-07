package org.agora;

import org.keycloak.authentication.InitiatedActionSupport;
import org.keycloak.authentication.RequiredActionContext;
import org.keycloak.authentication.RequiredActionProvider;
import org.keycloak.models.KeycloakSession;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.common.util.Time;

import javax.ws.rs.core.Response;
import java.util.function.Consumer;
import java.util.Arrays;

public class SurveyRequiredAction implements RequiredActionProvider {

	private final KeycloakSession session;

	public SurveyRequiredAction(KeycloakSession session) {
		this.session = session;
	}

	@Override
	public InitiatedActionSupport initiatedActionSupport() {
			return InitiatedActionSupport.SUPPORTED;
	}

	@Override
	public void evaluateTriggers(RequiredActionContext context) {

	}

	@Override
	public void requiredActionChallenge(RequiredActionContext context) {
		context.challenge(createForm(context, null));
	}

	protected Response createForm(RequiredActionContext context, Consumer<LoginFormsProvider> formCustomizer) {
		LoginFormsProvider form = context.form();
		return form.createForm("link-survey.ftl");
	}

	@Override
	public void processAction(RequiredActionContext context) {
		context.getUser().setAttribute("has seen Survey", Arrays.asList(Integer.toString(Time.currentTime())));
		context.success();
	}

	@Override
	public void close() {

	}

}