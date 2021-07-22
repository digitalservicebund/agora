<?php
$CONFIG = array (
	// for docker setup
	'config_is_read_only' => true,

	// for proxies
	'trusted_domains' =>
	array (
		0 => 'test.agora-oegd.de',
		1 => 'IP',
		2 => 'PROXIES',
	),
	'overwrite.cli.url' => 'https://test.agora-oegd.de',
	'overwriteprotocol' => 'https',
	'overwritehost' => 'test.agora-oegd.de',
	# get this from `docker inspect edge` & `docker inspect edge_reverse-proxy`
	'trusted_proxies' => ['PROXY_IP'],

	// usability 
	'default_language' => 'de_DE',
	'default_locale' => 'de_DE',
	'default_phone_region' => 'DE',
	'skeletondirectory' => '',
	'knowledgebaseenabled' => false,

	// use docker images for apps instead
	'appstoreenabled' => false,

	// debugging
	'loglevel' => '0',
	'debug' => true,

	// Mail
  'mail_smtpmode' => 'smtp',
  'mail_sendmailmode' => 'smtp',
  'mail_from_address' => 'info',
  'mail_domain' => 'DOMAIN',
  'mail_smtpauthtype' => 'LOGIN',
  'mail_smtpauth' => 1,
  'mail_smtphost' => 'HOST',
  'mail_smtpport' => 'PORT',
  'mail_smtpname' => 'NAME',
  'mail_smtppassword' => 'PASSWORD',
);