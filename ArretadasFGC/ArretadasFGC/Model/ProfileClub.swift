//
//  ProfileClub.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
import CoreData

class ProfileClub {
	
	func isAMember(user: User, members: [User]) -> Bool{
		return members.contains(user)
	}
}
