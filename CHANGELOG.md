# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check [Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## [Unreleased]

## 0.1.0 - 2026-09-11

* [Feature] Build a vCard 3.0 from a name, a number and whatever else is worth saving --
  `Crest::Card.new(name:, phone:, url:, email:, org:, photo:).to_s` -- CRLF-delimited, folded at
  74 characters with the continuation space the format asks for, and with the photo typed PNG or
  JPEG by its own first bytes rather than by anything the caller declares. Plain Ruby: it loads
  and answers with no Rails in the process
* [Feature] Draw the card at a path the host names with `crest 'houseaccount.vcf'`, a routes DSL
  method rather than an engine to mount, so the line may sit inside a `scope` or a `constraints`.
  The controller it draws to descends from `ActionController::Base` and not from the host's
  `ApplicationController`, since the card is public by definition and an inherited
  `before_action :authenticate` would refuse the one request it exists to answer
* [Feature] State the name, number, URL, email, organization and picture in one initializer, each
  of them a value or a callable resolved per request, so a number read out of the environment is
  right in production and in staging without a restart
