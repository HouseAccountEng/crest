# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check [Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## [Unreleased]

## 1.0.1 - 2026-09-11

* [Fix] Let Ruby autoload `Crest::CardsController` when a request first names it, rather than
  requiring it from a `to_prepare` block. `to_prepare` runs before the host has finished
  initializing, so the require pulled in `ActionController::Base` there -- which costs a host
  its boot time and which Rails reports as a prematurely executed load hook

## 1.0.0 - 2026-09-11

* [Breaking change] Answer `Crest::Photo#property` where `#to_s` used to answer, and leave a
  picture that is neither a PNG nor a JPEG off the card -- warned about on stderr, which a host
  already collects -- rather than raising. A card without a picture beats a 500 on a route
  that is public by definition, and a `to_s` that can answer nil is a trap for anyone
  interpolating one
* [Breaking change] Drop `Crest::Photo.of` and the process-wide hash of pictures behind it, so
  `Crest::Card` builds a `Crest::Photo` and the gem holds no mutable global state at all. It saved
  one file read and one base64 of a few kilobytes on a route hit occasionally, and charged for it
  with a hash keyed on whatever was handed in -- the image bytes themselves, where a host passes
  bytes -- never evicted, growing without bound for any host whose `photo` callable resolves to
  more than one picture, and blind to a file that changed on disk
* [Feature] Say that the card is an organization's: `N:` carries the one name a business has,
  which is what makes `name` a single setting rather than a compromise

## 0.1.1 - 2026-09-11

* [Fix] Name HouseAccount, Inc. as the copyright holder in the license, which 0.1.0 shipped
  naming the author instead

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
