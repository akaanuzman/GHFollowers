//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 24/8/23.
//

import UIKit

/// For UserInfoVC buttons to event handling
protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollwers(for user: User)
}

class UserInfoVC: UIViewController {
    var username: String!

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    lazy var itemViews: [UIView] = []
    var favorite: Follower?

    /// It is used to exit the screen when the get followers button is clicked and access the relevant user's information again.
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [doneButton, addButton]
    }

    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }

    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    private func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self

        let followerItemVC = GFFollwerItemVC(user: user)
        followerItemVC.delegate = self

        add(childVC: GFUserInfoHeaderVC(user: user), to: headerView)
        add(childVC: repoItemVC, to: itemViewOne)
        add(childVC: followerItemVC, to: itemViewTwo)
        dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    @objc private func addButtonTapped() {
        guard let favorite = favorite else {
            presentGFAlertOnMainThread(title: "Something went wrong!", message: "", buttonTitle: "Ok")
            return
        }
        
        addFollowerToFavoriteList(on: favorite)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) { presentSafariVC(with: user.htmlUrl) }

    func didTapGetFollwers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
