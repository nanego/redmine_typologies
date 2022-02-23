Redmine Typologies
===================

This plugin adds a new Typology field to issues.
It works as global categories.

Typologies are set in the admin panel, as a list of values.
Do not forget to activate the Typology module for each project.

## API

When using the API, the parameter "include=typologies" is required to get the typology of an issue.
For example:
https://redmine-url/issues/12345.json?key={apikey}&include=typologies

## Test status

|Plugin branch| Redmine Version   | Test Status      |
|-------------|-------------------|------------------|
|master       | 4.2.4             | [![4.2.4][1]][5] |  
|master       | 4.1.6             | [![4.1.6][2]][5] |
|master       | master            | [![master][4]][5]|

[1]: https://github.com/nanego/redmine_typologies/actions/workflows/4_2_4.yml/badge.svg
[2]: https://github.com/nanego/redmine_typologies/actions/workflows/4_1_6.yml/badge.svg
[4]: https://github.com/nanego/redmine_typologies/actions/workflows/master.yml/badge.svg
[5]: https://github.com/nanego/redmine_typologies/actions
