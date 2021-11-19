//
//  I18NExampleViewController.swift
//  MJRefreshExample
//
//  Created by Frank on 2021/7/5.
//  Copyright © 2021 小码哥. All rights reserved.
//
import UIKit

class I18NExampleViewController: UITableViewController {
    var languages = [
        "zh-Hans", "zh-Hant", "en", "ru", "ko", "uk"
    ]
    var customBundles = [
        "zh-Hans", "zh-Hant", "en", "ru", "ko", "uk"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        MJRefreshNormalHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else { return }
                self.tableView.mj_header?.endRefreshing()
            }
        }.autoChangeTransparency(true).link(to: tableView)

        MJRefreshAutoNormalFooter {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else { return }
                self.tableView.mj_footer?.endRefreshing()
            }
        }.link(to: tableView)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!

        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "MJRefresh 系统包或 MainBundle 中默认语言包"
        case 1:
            return "🍬自定义语言包文件(MJRefresh_i18n.strings)"
        case 2:
            return "♿️自定义语言包 bundle(CustomLanguages.bundle)"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            MJRefreshConfig.default.i18nFilename = "MJRefresh_i18n"
            MJRefreshConfig.default.languageCode = nil
            MJRefreshConfig.default.i18nBundle = nil
        case 2:
            MJRefreshConfig.default.i18nFilename = nil
            MJRefreshConfig.default.languageCode = nil
            MJRefreshConfig.default.i18nBundle = Bundle(path: Bundle.main.path(forResource: "CustomLanguages", ofType: "bundle")!)
        default:
            MJRefreshConfig.default.i18nFilename = nil
            MJRefreshConfig.default.languageCode = nil
            MJRefreshConfig.default.i18nBundle = nil
        }

        MJRefreshConfig.default.languageCode = languages[indexPath.row]

        let alertC = UIAlertController(title: "⚠️", message: "language changed to '\(languages[indexPath.row])'", preferredStyle: .alert)

        alertC.addAction(UIAlertAction(title: "🎉", style: .destructive))

        present(alertC, animated: true)
    }
}