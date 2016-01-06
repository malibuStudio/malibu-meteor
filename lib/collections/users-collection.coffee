# --------------------------------------------------------
# Reference Links
# --------------------------------------------------------
# Default REGEX included in SimpleSchema
# https://github.com/aldeed/meteor-simple-schema#regex

@Schema = {}

@Schema.UserCountry = new SimpleSchema
  name:
    type: String
  code:
    type: String
    regEx: /^[A-Z]{2}$/

@Schema.UserProfile = new SimpleSchema
  firstName:
    type: String
    optional: true
  lastName:
    type: String
    optional: true
  birthday:
    type: Date
    optional: true
  gender:
    type: String
    allowedValues: [
      'Male'
      'Female'
      '남성'
      '여성'
      '남자'
      '여자'
    ]
    optional: true
  organization:
    type: String
    optional: true
  website:
    type: String
    regEx: @SimpleSchema.RegEx.Url
    optional: true
  bio:
    type: String
    optional: true
  country:
    type: @Schema.UserCountry
    optional: true

@Schema.User = new SimpleSchema
  username:
    type: String
    optional: true
  emails:
    type: Array
    optional: true
  'emails.$':
    type: Object
  'emails.$.address':
    type: String
    regEx: @SimpleSchema.RegEx.Email
  'emails.$.verified':
    type: Boolean
  createdAt:
    type: Date
    denyUpdate: true
    autoValue: ()->
      if @isInsert
        return new Date()
  profile:
    type: @Schema.UserProfile
    optional: true
  services:
    type: Object
    optional: true
    blackbox: true
  # ROLES
  # Option 1 to add Objects as role
  # roles:
  #   type: Object
  #   optional: true
  #   blackbox: true
  # Option 2 to add Objects as array of string
  roles:
    type: [ String ]
    optional: true
  # In order to avoid an 'Exception in setInterval callback' from Meteor
  heartbeat:
    type: Date
    optional: true

Meteor.users.attachSchema Schema.User
