package igo;
 
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import net.reduls.igo.Morpheme;
import net.reduls.igo.Tagger;
public class Igo_create {
    public  void igo(String text) throws FileNotFoundException, IOException {
        System.out.println("igo");
    	Tagger tagger = new Tagger( "ipadic" );
        // parseÇÃé¿çs
        List<Morpheme> list = tagger.parse(text);
        for( Morpheme morph : list )
            System.out.println(morph.surface + ", " + morph.feature + ", " + morph.start);
    }
}