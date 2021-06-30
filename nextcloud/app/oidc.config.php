<?php
$CONFIG = array (
  // OIDC Login
  'allow_user_to_change_display_name' => false,
  'lost_password_link' => 'disabled',
  
  'oidc_login_disable_registration' => false,
  'oidc_login_auto_redirect' => true,
  'oidc_login_redir_fallback' => false,

  'oidc_create_groups' => true,

  // 'oidc_login_default_quota' => '1000000',
  'oidc_login_hide_password_form' => true,

  // get this from keycloak
  'oidc_login_client_id' => 'CLIENT_ID',
  'oidc_login_client_secret' => 'SECRET',
  'oidc_login_provider_url' => 'URL',
  'oidc_login_logout_url' => 'URL',
  'config_is_read_only' => true,
  'oidc_login_attributes' => array(
    'id' => 'preferred_username',
    'name' => 'name',
    'mail' => 'email',
    'groups' => 'groups'
  ),
);