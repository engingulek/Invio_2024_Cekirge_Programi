///MARK: UITableViewDelegate,UITableViewDataSource
import UIKit

extension MainViewController: UITableViewDelegate,UITableViewDataSource  {
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
         return viewModel.numberOfSections()
    }
    
     func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfRowsInSection(section: section)
    }
    
     func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UniversityTableViewCell.identifier)
                as? UniversityTableViewCell else { return UITableViewCell()}
         let item = viewModel.cellForRowAt(indexPath: indexPath)
         cell.configureData(cellForRowAtReturn: item)
         cell.isUserInteractionEnabled = true
         cell.delegate = self
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = SectionView()
         let item = viewModel.viewForHeaderInSection(section: section)
        sectionView.configureData(
            title: item.title,
            sectionData: section,
            iconButtonState: item.iconButtonImageState, iconImageTitle: item.iconImage)
        sectionView.delegate = self
        return sectionView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.nextPageLoad()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
    

     func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
         return viewModel.heightForHeaderInSection()
        }
    
  
     func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
         viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
    
}
