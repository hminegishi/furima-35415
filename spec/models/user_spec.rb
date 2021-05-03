require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、
      family_nameとfirst_name、family_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上で,半角英数字混合での入力があれば登録できる' do
        @user.password = 'a00000'
        @user.password_confirmation = 'a00000'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに@がついていないと登録できない' do
        @user.email = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは、英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordは、数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordは、全角では登録できない' do
        @user.password = '１２３あいう'
        @user.password_confirmation = '１２３あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字が空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name Full-width characters'
    end
    it 'ユーザー本名は、名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name Full-width characters'
    end
    it 'ユーザー名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.family_name = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name Full-width characters'
    end
    it 'ユーザー名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name Full-width characters'
    end
    it 'ユーザー本名のフリガナは、名字が空では登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name kana can't be blank"
    end
    it 'ユーザー本名のフリガナは、名前が空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end
    it 'ユーザー名字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.family_name_kana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Family name kana Full-width katakana characters'
    end
    it 'ユーザー名前のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana Full-width katakana characters'
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end
  end
end
