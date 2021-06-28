import reportBtn from "./reportBtn"
import reportInfo from "./reportInfo"

export default class reportApp{
    constructor($target) {
        this.reportBtn = new reportBtn({
            $target,
            OnClick: () => {
                this.reportInfo.setState({
                    visible: true
                })
            }
        });
        this.reportInfo = new reportInfo();
    }
}