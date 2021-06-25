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
	'trusted_proxies' => ['PROXY_IP'],

	// usability 
	'default_phone_region' => 'DE',
	'skeletondirectory' => '',

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