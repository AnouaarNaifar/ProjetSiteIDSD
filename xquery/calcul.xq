xquery version "3.1";
(: Import du module EXPath qui permet de manipuler les fichiers (écriture/lecture). :)
import module namespace file = "http://expath.org/ns/file";

(: On parcourt ici une liste de fichiers. Ici, seulement "etudiants.xml" :)
for $f in ("etudiants.xml")

let $etudiants := 
  <etudiants> {
    for $etudiant in doc($f)//etudiant

    (: On récupère les attributs "id" et "niveau" de chaque étudiant :)
    let $id := $etudiant/@id
    let $niveau := $etudiant/@niveau

    (: Calcul de la moyenne pondérée :)
    let $moyenne := 
      let $notes := $etudiant/notes/note
      let $total := sum(for $n in $notes return xs:decimal($n) * xs:decimal($n/@coeff))

      (: Somme des coefficients :)
      let $coeff := sum(for $n in $notes return xs:decimal($n/@coeff))
      return round($total div $coeff * 100) div 100

    return 
      <etudiant niveau="{$niveau}" id="{$id}"> {
        $etudiant/photo,
        $etudiant/nom,
        $etudiant/prenom,
        $etudiant/date_naissance,
        $etudiant/adresse,
        $etudiant/telephone,
        $etudiant/email,
        $etudiant/formation,
        $etudiant/specialite,
        $etudiant/niveau,
        $etudiant/notes,
        <moyenne>{$moyenne}</moyenne>
      }</etudiant>
  } </etudiants>
  
(: On prépare le nom du fichier de sortie, en ajoutant "_moyenne" à la fin :)
let $filename := replace($f, "\.xml$", "_moyenne.xml")  (: Ajouter "_moyenne" au nom du fichier :)

return file:write("E:/ENETCOM/1IDSD2/S2/web/examen/xml/" || $filename, $etudiants)
