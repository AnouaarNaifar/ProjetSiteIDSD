(:xquery version "3.1";

<etudiants>{
  for $e in doc("etudiants_moyenne.xml")//etudiant
  return 
    <etudiant>
      { $e/nom }
      { $e/prenom }
      { $e/moyenne }
    </etudiant>
}</etudiants>
:)
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5.0";

let $niveau := request:get-parameter("niveau", "")
let $etudiants := 
  if ($niveau != "") then
    doc("etudiants_moyenne.xml")//etudiant[niveau = $niveau]
  else
    doc("etudiants_moyenne.xml")//etudiant

return
  <div class="etudiants-list">
    <h2>Liste des Étudiants</h2>
    <table class="notes-table">
      <thead>
        <tr>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Moyenne</th>
          <th>Niveau</th>
        </tr>
      </thead>
      <tbody>
        {
          for $e in $etudiants
          order by $e/nom
          return
            <tr>
              <td>{data($e/nom)}</td>
              <td>{data($e/prenom)}</td>
              <td>{data($e/moyenne)}/20</td>
              <td>{data($e/niveau)}</td>
            </tr>
        }
      </tbody>
    </table>
  </div>