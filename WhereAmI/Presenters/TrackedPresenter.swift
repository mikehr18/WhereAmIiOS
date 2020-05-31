//
//  TrackedPresenter.swift
//  WhereAmI
//
//  Created by Aldo Corona on 28/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class TrackedPresenter {
    private var trackedInteractor: TrackedInteractor?
    private var trackedViewDelegate: TrackedViewDelegate?
    private var validation: Validation?
    
    init() {
        trackedInteractor = TrackedInteractor()
        validation = Validation()
    }
    
    func setViewDelegate(trackedView: TrackedViewDelegate?) {
        self.trackedViewDelegate = trackedView
    }
    
    func tryLogin(name: String, date: String, illness: String, idDevice: String, token: String) -> Void {
        if validation?.checkName(name: name) == true {
            if validation?.checkName(name: illness) == true {
                trackedInteractor?.addTrackedRequest(name: name, date: date, illness: illness, idDevice: idDevice, token: token){ successModel in
                    if successModel?.success == true {
                        self.trackedViewDelegate?.successFunc()
                    } else {
                        self.trackedViewDelegate?.notAdded(message: "Intente de nuevo más tarde")
                    }
                }
            } else {
                self.trackedViewDelegate?.notAdded(message: "Carácteres no válidos en enfermedad")
            }
        } else {
            self.trackedViewDelegate?.notAdded(message: "Nombre no válido")
        }
    }
}
