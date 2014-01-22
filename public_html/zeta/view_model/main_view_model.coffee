namespace Zeta:ViewModel:
  class MainViewModel
    constructor: (config) ->
      # Properties
      @conversation_input_text = ko.observable ""
      @conversation_intro = ko.observable "Please login..."
      @conversations = ko.observableArray []
      @conversation_messages = ko.observableArray []
      # Functions
      @send_knock = (conversation, event) =>
        callback = (data, textStatus, jqXHR) =>
          alert "HELLO!"
      
        Zeta.Service.Main.send_knock Zeta.Storage.Session.current_conversation_id, callback
        
      @send_hot_knock = (conversation, event) =>
        callback = (data, textStatus, jqXHR) =>
          alert "HEY!"
      
        Zeta.Service.Main.send_hot_knock Zeta.Storage.Session.current_conversation_id, callback        
      
      @send_message_to_conversation = (data, event) =>
        cid = Zeta.Storage.Session.current_conversation_id
        message = @conversation_input_text()
        callback = (data, textStatus, jqXHR) =>          
          @conversation_messages.push data.data.content
            
        Zeta.Service.Main.post_message_to_conversation cid, message, callback
        
      @open_conversation = (conversation, event) =>
        @conversation_intro "<b>#{conversation.name}</b>"
        Zeta.Storage.Session.current_conversation_id = conversation.id
      
        callback = (data, textStatus, jqXHR) =>
          @conversation_messages.removeAll()
          for k, v of data.messages
            from_uid = v.from
            user = Zeta.Storage.Session.get_users()[from_uid]
            if user?
              @conversation_messages.push "#{user.name}: #{v.data.content}"
            else
              get_user_callback = (data, textStatus, jqXHR) ->
                unknown_user = new Zeta.Model.User()
                unknown_user.init data
                # Cache the name of the unknown user
                Zeta.Storage.Session.get_users()[data.id] = unknown_user
                # TODO: Search & replace id with user's name or use a model binding
              Zeta.Service.Main.get_user_by_id from_uid, get_user_callback
              @conversation_messages.push "#{v.from}: #{v.data.content}"
          
        Zeta.Service.Main.get_latest_conversation_messages conversation.id, 100, callback