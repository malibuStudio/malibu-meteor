Template.register.helpers
  registerForm: ()->
    Malibu.forms.register

Template.register.events
  'submit form#register-form': (e, t)->
    e.preventDefault()

    btn = document.getElementById 'register-button'
    btn.classList.add 'loading'

    rf = Malibu.forms.register

    pass = t.find("[name=#{rf.password.name}]").value
    passConf = t.find("[name=#{rf.passwordConfirm.name}]").value

    if pass isnt passConf
      console.log 'Passwords do not match'
      return false

    obj =
      username: t.find("[name=#{rf.username.name}]").value.trim()
      email: t.find("[name=#{rf.email.name}]").value.trim()
      password: t.find("[name=#{rf.password.name}]").value
      roles: [rf.roles.default]

    Meteor.call 'register', obj, (err, res)->
      if err
        btn.classList.remove 'loading'
        console.log err.reason
      else
        Meteor.loginWithPassword res.username, res.password, (err, result) ->
          if err
            console.log err.reason
          else
            btn.classList.remove 'loading'
            console.log 'Register Successful'


Template.register.onRendered ->