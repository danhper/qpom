class Qpom.Views.SearchView extends Backbone.View
    el: '#search'

    events:
        'click select option': 'loadSubList'

    loadSubList: (e) ->
        option = $(e.target)
        selectTag = option.parent('select')
        selectList = selectTag.parents('fieldset').find('select')
        searchId = parseInt(option.val())

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

