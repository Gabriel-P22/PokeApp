import UIKit

class ViewController: UIViewController {
    
    private var pokemon: [PokemonEntry] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        setConstraints()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        getApi()
    }
    
    func getApi() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            [weak self] in
            PokeApi().getData() { [self] pokemon in
                self?.pokemon = pokemon
                
                guard let pokemon = self?.pokemon else { return }
                
                self?.tableView.reloadData()
            }
        }
    }
 
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        let pokemonDataCell = pokemon[indexPath.row]
        
        
        cell.textLabel?.text = pokemonDataCell.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(namePokemons.count)
        return pokemon.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Pokemons"
    }
    
}
