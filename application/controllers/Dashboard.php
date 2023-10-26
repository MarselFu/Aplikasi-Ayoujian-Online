<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_Controller {

	public function __construct(){
		parent::__construct();
		if (!$this->ion_auth->logged_in()){
			redirect('auth');
		}
		$this->load->model('Dashboard_model', 'dashboard');
		$this->user = $this->ion_auth->user()->row();
	}

	public function admin_box()
	{
		$box = [
			[
				'box' 		=> 'light-blue',
				'total' 	=> $this->dashboard->total('jurusan'),
				'title'		=> 'Jurusan',
				'icon'		=> 'graduation-cap'
			],
			[
				'box' 		=> 'olive',
				'total' 	=> $this->dashboard->total('kelas'),
				'title'		=> 'Kelas',
				'icon'		=> 'building-o'
			],
			[
				'box' 		=> 'yellow-active',
				'total' 	=> $this->dashboard->total('dosen'),
				'title'		=> 'Dosen',
				'icon'		=> 'user-secret'
			],
			[
				'box' 		=> 'red',
				'total' 	=> $this->dashboard->total('mahasiswa'),
				'title'		=> 'Mahasiswa',
				'icon'		=> 'user'
			],
		];
		$info_box = json_decode(json_encode($box), FALSE);
		return $info_box;
	}

	public function index()
	{
		$user = $this->user;
		$data = [
			'user' 		=> $user,
			'judul'		=> 'Dashboard',
			'subjudul'	=> 'Data Aplikasi',
		];

		if ($this->ion_auth->is_admin()) {
			$data['info_box'] = $this->admin_box();
		} elseif ($this->ion_auth->in_group('dosen')) {
			$matkul = ['matkul' => 'dosen.matkul_id=matkul.id_matkul'];
			$data['dosen'] = $this->dashboard->get_where('dosen', 'nip', $user->username, $matkul)->row();
		
			$kelas = ['kelas' => 'kelas_dosen.kelas_id=kelas.id_kelas'];
			$data['kelas'] = $this->dashboard->get_where('kelas_dosen', 'dosen_id', $data['dosen']->id_dosen, $kelas, ['nama_kelas' => 'ASC'])->result();
		
			// Loop through each class to add the associated department information
			foreach ($data['kelas'] as &$kelas) {
				$jurusan = ['jurusan' => 'kelas.jurusan_id=jurusan.id_jurusan'];
				$kelas->nama_jurusan = $this->dashboard->get_where('kelas', 'id_kelas', $kelas->kelas_id, $jurusan)->row()->nama_jurusan;
			}
		} else {
			$join = [
				'kelas b'     => 'a.kelas_id = b.id_kelas',
				'jurusan c'   => 'b.jurusan_id = c.id_jurusan'
			];
		
		
			$data['mahasiswa'] = $this->dashboard->get_where('mahasiswa a', 'nim', $user->username, $join)->row();
		}

		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('dashboard');
		$this->load->view('_templates/dashboard/_footer.php');
	}
}