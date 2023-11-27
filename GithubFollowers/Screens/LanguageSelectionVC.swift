import UIKit

class LanguageSelectionVC: UIViewController {
    let languageTableView = UITableView()
    let supportedLanguages = ["en-US", "tr-US"]
    let supportedLangList = [NSLocalizedString("english", comment: ""), NSLocalizedString("turkish", comment: "")]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("select_language", comment: "")
    }

    func setupUI() {
        languageTableView.dataSource = self
        languageTableView.delegate = self
        languageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        view.addSubview(languageTableView)

        // NSLayoutConstraint kullanarak arayüzü yerleştirme
        languageTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            languageTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            languageTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            languageTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }

    func changeLanguage(_ selectedLanguage: String) {
        print("Selected Language: \(selectedLanguage)")

        PersistenceManager.changeLanguage(to: selectedLanguage)
    
        navigationController?.popViewController(animated: true)
    }
}

extension LanguageSelectionVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportedLangList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        cell.textLabel?.text = supportedLangList[indexPath.row]
        cell.tintColor = .systemGreen

        let currentLanguage = LanguageManager.shared.currentLanguage
        if supportedLanguages[indexPath.row] == currentLanguage[0] {
            cell.accessoryType = .checkmark

        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = supportedLanguages[indexPath.row]
        changeLanguage(selectedLanguage)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
