//
//  Lang.swift
//  Task_Managment
//
//  Created by Ali on 13/01/23.
//

import Foundation
import UIKit


class Lang {
    
    static func getString(type: StringType) -> String {
        ///give StringType enum for taking translated String value (language depends from value of key:  "APP_LANGUAGE")
        
        switch Cache.getAppLanguage() {
            
            
            //
        case .ru :  //MARK: When Language is Russian
            switch type {
                //Task Management & To-Do List
            case .startVCTitle: return "Проект Менеджмент и Список Задач"
                //This productive tool is designed to help you better manage your task project-wise conveniently!
            case .startVCDescrypt: return "Этот продуктивный инструмент разработан для того, чтобы помочь вам лучше управлять своими задачами с точки зрения проекта и удобно!"
                //Get Started
            case .getStart: return "Начать"
                //Select Language
            case .selectLang: return "Выбрать язык"
                //Continue
            case .continu: return "Продолжить"
                
            case .start: return "Начать"
                
            case .signipVCDesc: return "Начните выполнять всю свою работу по плану"
                
            case .signIn: return "Вход"
                
            case .password: return "Пароль"
                
                
            case .all: return "Все"
                
            case .inProgress: return "В Процессе"
                
            case .completed: return "Завершено"
                
            case .toDo: return "Новые"
                
            case .todaysTask: return "Сегодняшние Задания"
                
            case .verifCode: return "Код подтверждения"
                
            case .verifDesc: return "Пожалуйста введите код отправленный на номер"
                
            case .resend: return "Отправить заново"
                
            case .datE: return "Дата:"
                
            case .timE: return "Время:"
                
            case .locatioN: return "Локация:"
                
            case .writeComm: return "Написать комментарий"
                
            case .editProf: return "Изменить профиль"
                
            case .tasks: return "Задания"
                
            case .statistics: return "Статистика"
                
            case .notifications: return "Уведомления"
                
            case .security: return "Конфеденциальность"
                
            case .help: return "Помощь"
                
            case .logout: return "Выход"
                
            case .name: return "Имя"
                
            case .surname: return "Фамилия"
                
            case .dateBirth: return "Дара рождения"
                
            case .number: return "Номер"
                
            case .save: return "Сохранить"
                
            case .change: return "Изменить"
                
            case .profile: return "Профиль"
                
            case .comment: return "Комментарий"
                
            case .enterSms: return "Введите сообщение"
                
            case .tasksCompleted: return "Заданий выполнено"
                
            case .todaysTasks: return "Сегодняшние Задания"
                
            case .viewTask: return "Посмотреть Задание"
                
            case .privacyPolicyDescrypt: return "Продолжая, вы соглашаетесь с Условиями Использования и Политикой Конфиденциальности"
                
            case .termsUse: return "Условиями Использования"
                
            case .privacyPolicy: return "Политикой Конфиденциальности"
                
            case .alertError: return "Ошибка"
                
            case .alertEnterNumb: return "Пожалуйста введите номер или пароль"
                
            case .alertNumbError: return "Ошибка при вводе данных или нет такого пользователя"
                
            case .totalTime: return "Общее время"
                
            case .startTask: return "Начать Задание"
                
            case .finishTask: return "Завершить Задание"
                
            case .chooseDate: return "Выберите нужное время"
                
            case .changeLang: return "Изменить язык"
                
            case .noSms: return "Нет сообщений"
                
            case .mon: return "Пн"
            case .tue: return "Вт"
            case .wed: return "Ср"
            case .thu: return "Чт"
            case .fri: return "Пт"
            case .sat: return "Сб"
            case .sun: return "Вс"
            }
            
            //
        case .uz:   //MARK: When Language is Uzbek
            switch type {
            case .continu: return "Davom etish"
            case .startVCTitle: return "Vazifalarni Boshqarish Va Vazifalar Ro'yxati"
                
            case .startVCDescrypt: return "Ushbu samarali vosita yordam berish uchun mo'ljallangan vazifangizni yaxshiroq boshqarasiz loyiha-dono qulay!"
                
            case .start: return "Boshlash"
                
            case .getStart: return "Boshlash"
                
            case .signipVCDesc: return "Barcha ishlaringizni reja bilan bajarishni boshlang"
                
            case .signIn: return "Kirish"
                
            case .password: return "Parol"
                
            case .selectLang: return "Tilni Tanlash"
                
            case .all: return "Barchasi"
                
            case .inProgress: return "Jarayonda"
                
            case .completed: return "Bajarilgan"
                
            case .toDo: return "Yangi"
                
            case .todaysTask: return "Bugungi Vazifa"
                
            case .verifCode: return "Tasdiqlash kodi"
                
            case .verifDesc: return "Iltimos quyidagi raqamga jo'natilgan kodni kiriting"
                
            case .resend: return "Ohirgi"
                
            case .datE: return "Sana:"
                
            case .timE: return "Vaqt:"
                
            case .locatioN: return "Manzil:"
                
            case .writeComm: return "Izoh qoldirish"
                
            case .editProf: return "Profilni O'zgartirish"
                
            case .tasks: return "Vazifalar"
                
            case .statistics: return "Statistika"
                
            case .notifications: return "Habarnomalar"
                
            case .security: return "Xafsizlik"
                
            case .help: return "Yordam"
                
            case .logout: return "Chiqish"
                
            case .name: return "Ism"
                
            case .surname: return "Familiya"
                
            case .dateBirth: return "Tug'ilgan sana"
                
            case .number: return "Raqam"
                
            case .save: return "Saqlash"
                
            case .change: return "O'zgartirish"
                
            case .profile: return "Profil"
                
            case .comment: return "Izoh"
                
            case .enterSms: return "Xabar qoldirish"
                
            case .tasksCompleted: return "Vazifa bajarildi"
                
            case .todaysTasks: return "Bugungi Vazifalar"
                
            case .viewTask: return "Vazifani Ko'rish"
                
            case .privacyPolicyDescrypt: return "Davom etish orqali siz Fpydalanish Shartlari va Maxfiylik Siyosatiga rozilik bildirasiz"
                
            case .termsUse: return "Fpydalanish Shartlari"
                
            case .privacyPolicy: return "Maxfiylik Siyosatiga"
                
            case .alertError: return "Hatolik"
                
            case .alertEnterNumb: return "Iltimos, raqam yoki parolni kiriting"
                
            case .alertNumbError: return "Ma'lumot kiritishda xatolik bor yoki bunday foydalanuvchi mavjud emas"
                
            case .totalTime: return "Umumiy vaqt"
                
            case .startTask: return "Vazifani Boshlash"
                
            case .finishTask: return "Vazifani Yakunlash"
                
            case .chooseDate: return "Kerakli vaqtni tanlang"
                
            case .changeLang: return "Tilni o'zgartirish"
                
            case .noSms: return "Habarlar yo'q"
                
            case .mon: return "Du"
            case .tue: return "Se"
            case .wed: return "Cho"
            case .thu: return "Pa"
            case .fri: return "Ju"
            case .sat: return "Sha"
            case .sun: return "Ya"
            }
            
            //
        case .en:   //MARK: When Language is English
            switch type {
                
            case .startVCTitle: return "Task Management & To-Do List"
                
            case .startVCDescrypt: return "This productive tool is designed to help you better manage your task project-wise conveniently!"
                
            case .getStart: return "Start"
                
            case .selectLang: return "Select Language"
                
            case .continu: return "Continue"
                
            case .start: return "Start"
                
            case .signipVCDesc: return "Start doing all your work with a plan"
                
            case .signIn: return "Sign In"
                
            case .password: return "Password"
                
            case .all: return "All"
                
            case .inProgress: return "In Progress"
                
            case .completed: return "Completed"
                
            case .toDo: return "To Do"
                
            case .todaysTask: return "Today's Task"
                
            case .verifCode: return "Verification code"
                
            case .verifDesc: return "Please enter the code sent to"
                
            case .resend: return "Resend"
                
            case .datE: return "Date:"
                
            case .timE: return "Time:"
                
            case .locatioN: return "Location:"
                
            case .writeComm: return "Write comment"
                
            case .editProf: return "Edit Profile"
                
            case .tasks: return "Tasks"
                
            case .statistics: return "Statistics"
                
            case .notifications: return "Notifications"
                
            case .security: return "Security"
                
            case .help: return "Help"
                
            case .logout: return "Logout"
                
            case .name: return "Name"
                
            case .surname: return "Surname"
                
            case .dateBirth: return "Date of birth"
                
            case .number: return "Number"
                
            case .save: return "Save"
                
            case .change: return "Change"
                
            case .profile: return "Profile"
                
            case .comment: return "Comment"
                
            case .enterSms: return "Enter a message"
                
            case .tasksCompleted: return "Tasks completed"
                
            case .todaysTasks: return "Today’s Tasks"
                
            case .viewTask: return "View Task"
                
            case .privacyPolicyDescrypt: return "By continuing, you agree to the Terms of Use and Privacy Policy"
                
            case .termsUse: return "Terms of Use"
                
            case .privacyPolicy: return "Privacy Policy Конфиденциальности"
                
            case .alertError: return "Error"
                
            case .alertEnterNumb: return "Please enter the phone number or password"
                
            case .alertNumbError: return "There is a data entry error or there is no such user"
                
            case .totalTime: return "Total time"
                
            case .startTask: return "Start Task"
                
            case .finishTask: return "Finish Task"
                
            case .chooseDate: return "Choose required date"
                
            case .changeLang: return "Change language"
                
            case .noSms: return "No message"
                
            case .mon: return "Mon"
            case .tue: return "Tue"
            case .wed: return "Wed"
            case .thu: return "Thu"
            case .fri: return "Fri"
            case .sat: return "Sat"
            case .sun: return "Sun"
            }
            
        }
    }
    
    
    enum StringType {
        case continu
        case startVCTitle
        case startVCDescrypt
        case start
        case getStart
        case signipVCDesc
        case signIn
        case password
        case selectLang
        case all
        case inProgress
        case completed
        case toDo
        case todaysTask
        case verifCode
        case verifDesc
        case resend
        case datE
        case timE
        case locatioN
        case writeComm
        case editProf
        case tasks
        case statistics
        case notifications
        case security
        case help
        case logout
        case name
        case surname
        case dateBirth
        case number
        case save
        case change
        case profile
        case comment
        case enterSms
        case tasksCompleted
        case todaysTasks
        case viewTask
        case privacyPolicyDescrypt
        case termsUse
        case privacyPolicy
        case alertError
        case alertEnterNumb
        case alertNumbError
        case totalTime
        case startTask
        case finishTask
        case chooseDate
        case changeLang
        case noSms
        
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
        case sun
    }
    
}
