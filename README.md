- Creo un nuovo progetto rails: rails new ticketee.
- Ho modificato il GEMFILE spostando web-console nel gruppo development, che ho creato a parte.
- Dopo aver installato le gemme di RSpec e Capybara e fatto il bundle install, ho avviato il comando di generazione del file .rpsec e della cartella rspec con: rails g rpsec:install.
- Ricorda: un test può fallire, essere eseguito con successo o rimanere in "pending". RSpec ci informa del progress dei test con una sintassi molto sintetica: ....F.....\*..... (il punto è un successo, F un fallimento e * un pending).

###Primo Step BDD: Creazione del progetto

- Creo una cartella features sotto spec, contenente un file creating_projects_spec.rb, in quanto la prima tappa di testing è la possibilità di creare un progetto da parte degli utenti.
- Ricorda: il file di test deve terminare col suffisso \_spec.
- Ho la possibilità di creare un file spec, a partire da un comando: rails g rspec:model Project o farne il reverse sostituendo la g (generate) con la d (destroy).
- Dovrò fare i seguenti step: creazione dell'instradamento, creazione del controller, creazione del metodo, creazione del template view.

In uno scenario di creazione di un progetto l'utente deve poter visitare la pagina root, cliccare sul link "Nuovo Progetto" e riempire i campi di Nome e Descrizione del Progetto, infine cliccando sul pulsante "Crea Progetto", ottenere una risposta di successo, del tipo "Progetto creato".
Per farlo creo uno script di BDD, con il primo step:

```
require "rails_helper"
RSpec.feature "Gli utenti possono creare nuovi progetti" do
  scenario "con attributi validi" do
    visit "/"
  end
end
```

Le parole feature e scenario corrispondono ai describe e it di RSpect, messi a disposizione da Capybara.
Avvio il test con rspec o con bundle exec rspec. Il test fallirà in quanto manca il routing verso la root della home page. Inoltre ottengo un warning sul fatto che non esiste un file schema.rb per il database, ma per ora posso ignorarlo.
Qui sto chiedendo a Rails di girare la REQUEST alla pagina "/" che però non esiste nel mio file di ROUTES.

Per definire l'instradamento principale, la ROOT ROUTE, uso il metodo root seguito da una sintassi che rappresenta il controller ed il metodo (ACTION) del controller:

```
Rails.application.routes.draw do
  root "projects#index"
end
```

Adesso l'errore è relativo al fatto che il CONTROLLER non esiste! Lo devo generare:

- Lancio il comando per la generazione del controller: rails g controller projects.
- Ricorda: i controllers vanno chiamati al plurale (e in inglese), questo perchè si intende che questa classe abbia a che fare con una plurità di progetti. Diverso invece è il MODEL che va al singolare.
- Mi crea un file proejcts_controller.rb in app/controllers, la relativa view in app/views/poejects la spec in spec/controllers, un modulo di helper e files di assets.
- Lancio il comando rspec e ora il problema è che non esiste l'ACTION index del controller.
- Definisco l'ACTION index nel controller, ma non sarà sufficiente, in quanto avrò bisogno di una VIEW.
- L'errore di RSpec ci segnala che abbiamo bisogno di un Template (MissingTemplate) che deve trovarsi o in projects o in application, questo perchè potrei avere un index "comune" in application e perchè i controllers che genero ereditano da ApplicationController. Viene specificato anche un handler, cioè una serie di preprocessor per la costruzione del mio template. I preprocessors possono esssere aggiunti tramite ulteriori GEMS.
- Creo un file index.html.erb in app/views/project, vuoto.
- A questo punto il test è eseguito con successo.
