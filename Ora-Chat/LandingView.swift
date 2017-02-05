//
//  LandingView.swift
//  Ora-Chat
//
//  Created by Brad Siegel on 2/2/17.
//  Copyright © 2017 Brad Siegel. All rights reserved.
//

import UIKit

class LandingView: UIView {
    
    @IBOutlet fileprivate weak var chatsTableView: UITableView!
    
    fileprivate var viewModel: LandingViewModel?
    var delegate: LandingDelegate?
    
    override func awakeFromNib() {
        self.chatsTableView.rowHeight = 65
    }
    
    func displayViewModel(viewModel: LandingViewModel) {
        self.viewModel = viewModel
        self.chatsTableView.reloadData()
    }
}

//MARK: UITableViewDelegate
extension LandingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chatId = self.viewModel?.chats[indexPath.row].id else { return }
        self.delegate?.didSelectChat(chatId: chatId)
        chatsTableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: UITableViewDataSource
extension LandingView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatsCell",
                                                 for: indexPath) as! ChatsTableViewCell
        let cellViewModel = ChatsTableViewCellViewModel(
            chat: (self.viewModel?.chats[indexPath.row])!)
        cell.displayViewModel(viewModel: cellViewModel)
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.chats.count ?? 0
    }
}
