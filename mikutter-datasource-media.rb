#coding: utf-8

Plugin.create(:mikutter_datasource_media) { 
  filter_extract_datasources { |datasources|
    [{mikutter_datasource_media: "画像付きツイートのみ"}.merge(datasources)]
  }

  on_update do |service, messages|
    Plugin.call :extract_receive_message, :mikutter_datasource_media, messages.select { |message|
       message.entity.any? { |entity| %i<media>.include? entity[:slug] }
    }
  end
}
