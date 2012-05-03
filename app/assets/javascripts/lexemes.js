$(document).ready(function(){   
    $('#lexemes_searchresults').dataTable(); 
    $('select#lexeme_pos').change(function(){
        if($('select#lexeme_pos').val() == "Noun"){
            $('div.ifNoun').show();
            var sg = $('input#lexeme_sgNounClassMorpheme').val() +  $('input#lexeme_root').val();
            var pl = $('input#lexeme_plNounClassMorpheme').val() +  $('input#lexeme_root').val();
            $('input#lexeme_sgTranscription').val(sg);
            $('input#lexeme_plTranscription').val(pl);
        }else{
            $('div.ifNoun').hide();
        }
        if($('select#lexeme_pos').val() == "Verb"){
            $('div.ifVerb').show();
        }else{
            $('div.ifVerb').hide();
        }
    });
});

