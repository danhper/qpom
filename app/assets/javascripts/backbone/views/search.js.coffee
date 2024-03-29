class Qpom.Views.ListView extends Backbone.View
    el: 'body'

    events:
        'vclick select option': 'loadSubList'
        'change select': 'loadSubList'

    loadSubList: (e) ->
        target = $(e.target)

        selectTag = if target.is('option') then target.parent('select') else target

        selectList = selectTag.parents('fieldset').find('select')
        searchId = parseInt(selectTag.val())

        for i in [0..selectList.size()]
            if selectTag.attr('id') == selectList.eq(i).attr('id')
                index = i + 1
                nextSelect = selectList.eq(index)

        if searchId == 0 or typeof nextSelect == 'undefined'
            return

        selectList.slice(index).each (index, select) ->
            $select = $(select)
            defaultOption = $select.children('option').first()
            $select.empty()
            $select.append defaultOption
            if $select.selectmenu?
                $select.selectmenu('refresh')

        switch index
            when 1 then collection = new Qpom.Collections.PrefecturesCollection
            when 2 then collection = new Qpom.Collections.TownsCollection
            else return

        collection.fetchWithId searchId, success: ->
            collection.forEach (item) ->
                option = $('<option />').attr 'value', item.get 'id' 
                option.text item.get('name')
                nextSelect.append option


