import UIKit

class ViewController: UIViewController {
    
    private var data: [String] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(tableView)
        
        setConstraints()
        
        getApi()
    }
    
    func getApi() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            [weak self] in
            self?.data.append("Mock 1")
            self?.data.append("Mock 2")
            self?.data.append("Mock 3")
            self?.data.append("Mock 4")
            self?.data.append("Mock 5")
            self?.tableView.reloadData()
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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        let model = data[indexPath.item]
        
        cell.textLabel?.text = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Pokemons"
    }
    
}
